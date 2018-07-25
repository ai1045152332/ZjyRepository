package com.zjy.blog.blog_start.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zjy.blog.blog_start.domain.Vote;
import com.zjy.blog.blog_start.repository.VoteRepository;


/**
 * Vote 服务实现.
 */
@Service
public class VoteServiceImpl implements VoteService {

    @Autowired
    private VoteRepository voteRepository;
    
	@Override
	public Vote getVoteById(Long id) {
		return voteRepository.findOne(id);
	}
	
	@Override
	public void removeVote(Long id) {
		voteRepository.delete(id);
	}

}