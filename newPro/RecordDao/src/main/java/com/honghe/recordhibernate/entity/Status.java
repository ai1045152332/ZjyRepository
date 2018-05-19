package com.honghe.recordhibernate.entity;

// Generated 2014-7-30 18:08:49 by Hibernate Tools 3.4.0.CR1

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Status generated by hbm2java
 */
@Entity
@Table(name = "status")
public class Status implements java.io.Serializable
{

	private Integer statusId;
	private String statusName;
	private String cnDesc;
	private String enDesc;

	public Status()
	{
	}

	public Status(String statusName, String cnDesc, String enDesc)
	{
		this.statusName = statusName;
		this.cnDesc = cnDesc;
		this.enDesc = enDesc;
	}

	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "status_id", unique = true, nullable = false)
	public Integer getStatusId()
	{
		return this.statusId;
	}

	public void setStatusId(Integer statusId)
	{
		this.statusId = statusId;
	}

	@Column(name = "status_name", length = 50)
	public String getStatusName()
	{
		return this.statusName;
	}

	public void setStatusName(String statusName)
	{
		this.statusName = statusName;
	}

	@Column(name = "cn_desc")
	public String getCnDesc()
	{
		return this.cnDesc;
	}

	public void setCnDesc(String cnDesc)
	{
		this.cnDesc = cnDesc;
	}

	@Column(name = "en_desc")
	public String getEnDesc()
	{
		return this.enDesc;
	}

	public void setEnDesc(String enDesc)
	{
		this.enDesc = enDesc;
	}

}