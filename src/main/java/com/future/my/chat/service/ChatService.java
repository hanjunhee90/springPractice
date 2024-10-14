package com.future.my.chat.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.future.my.chat.dao.IChatDAO;
import com.future.my.chat.vo.RoomVO;

@Service
public class ChatService {
	
	@Autowired
	IChatDAO dao;
	
	public ArrayList<RoomVO> getRoomList(){
		return dao.getRoomList();
	}
	
	// selectkey를 사용하면 void이여도 자동으로 roomVO에 roomNo 가 리턴됨
	public void createRoom(RoomVO roomVO) {
		dao.createRoom(roomVO);
	}

}
