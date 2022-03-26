package healthBoard.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class HealthBoardComment implements Serializable{

	private int healthBoardCommentNo;
	private int healthBoardCommentLevel;
	private String healthBoardCommentWriter;
	private String healthBoardCommentContent;
	private int healthBoardRef;
	private int healthBoardCommentRef;
	private Date healthBoardCommentDate;
	
	public HealthBoardComment() {
		super();
		// TODO Auto-generated constructor stub
	}

	public HealthBoardComment(int healthBoardCommentNo, int healthBoardCommentLevel, String healthBoardCommentWriter,
			String healthBoardCommentContent, int healthBoardRef, int healthBoardCommentRef,
			Date healthBoardCommentDate) {
		super();
		this.healthBoardCommentNo = healthBoardCommentNo;
		this.healthBoardCommentLevel = healthBoardCommentLevel;
		this.healthBoardCommentWriter = healthBoardCommentWriter;
		this.healthBoardCommentContent = healthBoardCommentContent;
		this.healthBoardRef = healthBoardRef;
		this.healthBoardCommentRef = healthBoardCommentRef;
		this.healthBoardCommentDate = healthBoardCommentDate;
	}

	public int getHealthBoardCommentNo() {
		return healthBoardCommentNo;
	}

	public void setHealthBoardCommentNo(int healthBoardCommentNo) {
		this.healthBoardCommentNo = healthBoardCommentNo;
	}

	public int getHealthBoardCommentLevel() {
		return healthBoardCommentLevel;
	}

	public void setHealthBoardCommentLevel(int healthBoardCommentLevel) {
		this.healthBoardCommentLevel = healthBoardCommentLevel;
	}

	public String getHealthBoardCommentWriter() {
		return healthBoardCommentWriter;
	}

	public void setHealthBoardCommentWriter(String healthBoardCommentWriter) {
		this.healthBoardCommentWriter = healthBoardCommentWriter;
	}

	public String getHealthBoardCommentContent() {
		return healthBoardCommentContent;
	}

	public void setHealthBoardCommentContent(String healthBoardCommentContent) {
		this.healthBoardCommentContent = healthBoardCommentContent;
	}

	public int getHealthBoardRef() {
		return healthBoardRef;
	}

	public void setHealthBoardRef(int healthBoardRef) {
		this.healthBoardRef = healthBoardRef;
	}

	public int getHealthBoardCommentRef() {
		return healthBoardCommentRef;
	}

	public void setHealthBoardCommentRef(int healthBoardCommentRef) {
		this.healthBoardCommentRef = healthBoardCommentRef;
	}

	public Date getHealthBoardCommentDate() {
		return healthBoardCommentDate;
	}

	public void setHealthBoardCommentDate(Date healthBoardCommentDate) {
		this.healthBoardCommentDate = healthBoardCommentDate;
	}

	@Override
	public String toString() {
		return "HealthBoardComment [healthBoardCommentNo=" + healthBoardCommentNo + ", healthBoardCommentLevel="
				+ healthBoardCommentLevel + ", healthBoardCommentWriter=" + healthBoardCommentWriter
				+ ", healthBoardCommentContent=" + healthBoardCommentContent + ", healthBoardRef=" + healthBoardRef
				+ ", healthBoardCommentRef=" + healthBoardCommentRef + ", healthBoardCommentDate="
				+ healthBoardCommentDate + "]";
	}
	
}
