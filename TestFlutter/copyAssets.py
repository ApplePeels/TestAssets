
#!/usr/bin/python
# -*- coding: UTF-8 -*-

import os
import json
import platform
from shutil import copyfile, rmtree

def _getPureFileName(fileName):
	fileName = fileName.rstrip('.png');
	fileName = fileName.rstrip('@2x.png');
	fileName = fileName.rstrip('@3x.png');
	return fileName;

def _generalImageNameInfoList(fileNameList):
	fileNameInfoList = []
	for fileName in fileNameList:
		fileNameInfo = {'idiom':'universal', 'scale':'1x', 'filename':fileName}
		if -1 != fileName.find('@2x'):
			fileNameInfo['scale'] = '2x'
		elif -1 != fileName.find('@3x'):
			fileNameInfo['scale'] = '3x'
		fileNameInfoList.append(fileNameInfo)

	find2x = False
	for fileName in fileNameList:
		if '@2x' in fileName:
			find2x = True
			break;

	find3x = False
	for fileName in fileNameList:
		if '@3x' in fileName:
			find3x = True
			break;

	if not find2x:
		fileNameInfoList.append({'idiom':'universal', 'scale':'2x'})
	if not find3x:
		fileNameInfoList.append({'idiom':'universal', 'scale':'3x'})

	return fileNameInfoList


def _removeDir(dirName):
	if os.path.exists(dirName):
		for root, dirs, files in os.walk(dirName):
			for fileName in files:
				os.remove(os.path.join(root, fileName))
		os.removedirs(dirName) 

def _copyAssets(imageDir, assetsDir):
	imageFileSet = {}
	for root, dirs, files in os.walk(imageDir):
		for fileName in files:

			if fileName == '.DS_Store':
				continue

			pureFileName = _getPureFileName(fileName)

			fileNameList = []
			if pureFileName in imageFileSet.keys():
				fileNameList = imageFileSet[pureFileName]
			fileNameList.append(fileName)
			imageFileSet[pureFileName] = fileNameList

	for key in imageFileSet.keys():
		imagesetName = key + '.imageset'
		imagesetPath = os.path.join(assetsDir, imagesetName)
		_removeDir(imagesetPath)
		os.makedirs(imagesetPath) 

		fileNameList = imageFileSet[key]
		imageNameInfoList = _generalImageNameInfoList(fileNameList)
		contentsInfo = json.dumps({'images':imageNameInfoList, 'info':{'version':1, 'author':'xcode'}}, indent=2)

		contentesFile = os.path.join(imagesetPath, 'Contents.json')
		if os.path.exists(contentesFile):
			os.remove(contentesFile)

		with open(contentesFile, 'w') as file:
			file.write(contentsInfo)

		for fileName in fileNameList:
			srcFilePath = os.path.join(imageDir, fileName)
			dstFilePath = os.path.join(imagesetPath, fileName)
			if os.path.exists(dstFilePath):
				os.remove(dstFilePath) 
			copyfile(srcFilePath, dstFilePath)

if __name__ == '__main__':
	print(platform.python_version())

	with open('./image.json', 'r') as file:
		imageJsonInfo = json.load(file)
		imageList = imageJsonInfo['imageList']
		for imageInfo in imageList:
			image = imageInfo['image']
			assets = imageInfo['assets']
			_copyAssets(image, assets);			







