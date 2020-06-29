#!/bin/bash

handleImagesetPath(){
	fileName=$1
	isRemove=$2
	pureFileName=${fileName}
	pureFileName=${pureFileName%.*}
	pureFileName=${pureFileName%@2x*}
	pureFileName=${pureFileName%@3x*}
	imagesetPath=${assetsDir}/${pureFileName}.imageset
	if [ 1 == ${isRemove} ]
	then
		rm -rf ${imagesetPath}
	else
		mkdir -p ${imagesetPath}
	fi
}

writeContentsInfo(){
	fileName=$1
	contentsFile=$2

	fileName1=${fileName%@2x*}
	fileName2=${fileName%@3x*}

	fileNameLen=${#fileName}
	fileNameLen1=${#fileName1}
	fileNameLen2=${#fileName2}

	# 判断是否存在多倍图
	tmpJsonFile=/var/tmp/tmpContentsFile
	if [[ ${fileNameLen} != ${fileNameLen1} || ${fileNameLen} != ${fileNameLen2} ]]
	then
		# 7->(@2x.png)
		index=${fileNameLen}-7
		tmpFileName=${fileName:index:3}
		if [ ${tmpFileName} == '@2x' ]
		then
			cat ${contentsFile} | jq '.images[1].filename'=\"${fileName}\" > ${tmpJsonFile}
		elif [ ${tmpFileName} == '@3x' ]
		then
			cat ${contentsFile} | jq '.images[2].filename'=\"${fileName}\" > ${tmpJsonFile}
		else
		cat ${contentsFile} | jq '.images[0].filename'=\"${fileName}\" > ${tmpJsonFile}
		fi
	else
		cat ${contentsFile} | jq '.images[0].filename'=\"${fileName}\" > ${tmpJsonFile}
	fi
	mv -f ${tmpJsonFile} ${contentsFile}
}

copyAssets(){
	imageDir=$1
	assetsDir=$2

	for fileName in `ls ${imageDir}`
	do
		# 清空已有imageset目录
		handleImagesetPath ${fileName} 1
	done


	for fileName in `ls ${imageDir}`
	do
		# 创建imageset目录
		handleImagesetPath ${fileName} 0

		# 拷贝资源文件
		srcFileName=${imageDir}/${fileName}
		desFileName=${imagesetPath}/${fileName}
		cp ${srcFileName} ${desFileName}

		# 拷贝Contents.json文件(文件存在则跳过)
		srcContentsFile=./Contents.json
		contentsFile=${imagesetPath}/Contents.json
		cp -n ${srcContentsFile} ${contentsFile}

		# 写入Contets.json信息
		writeContentsInfo ${fileName} ${contentsFile}
	done
}


# brew install jq


for row in `cat ./image.json | jq -r '.imageList[] | @base64'`
do  
    base64Decode(){
     	echo ${row} | base64 --decode | jq -r ${1}
    }

   	image=`base64Decode '.image'`
   	assets=`base64Decode '.assets'`

   	copyAssets ${image} ${assets}
done

# copyAssets ./Image ./Assets.xcassets