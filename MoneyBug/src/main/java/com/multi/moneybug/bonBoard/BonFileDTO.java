package com.multi.moneybug.bonBoard;

public class BonFileDTO {

private int seq;
private int boardSeq;
private String fileName;
private String filePath;
private long fileSize;
public int getSeq() {
	return seq;
}
public void setSeq(int seq) {
	this.seq = seq;
}
public int getFseq() {
	return boardSeq;
}
public void setFseq(int boardSeq) {
	this.boardSeq = boardSeq;
}
public String getFileName() {
	return fileName;
}
public void setFileName(String fileName) {
	this.fileName = fileName;
}
public String getFilePath() {
	return filePath;
}
public void setFilePath(String filePath) {
	this.filePath = filePath;
}
public long getFileSize() {
	return fileSize;
}
public void setFileSize(long fileSize) {
	this.fileSize = fileSize;
}

@Override
public String toString() {
	return "BonFileDTO [seq=" + seq + ", fseq=" + boardSeq + ", originalFileName=" + fileName + ", filePath="
			+ filePath + ", fileSize=" + fileSize + "]";
}
}
