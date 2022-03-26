package healthBoard.model.vo;

import java.sql.Date;

public class HealthBoardForList extends HealthBoard{

	private int commentCnt;

	public HealthBoardForList() {
		super();
		// TODO Auto-generated constructor stub
	}

	public HealthBoardForList(int boardNo, String boardTitle, String boardWriter, String boardContent,
			String boardOriginalFileName, String boardRenamedFileName, Date boardDate, int boardReadCount) {
		super(boardNo, boardTitle, boardWriter, boardContent, boardOriginalFileName, boardRenamedFileName, boardDate,
				boardReadCount);
		// TODO Auto-generated constructor stub
	}

	public HealthBoardForList(int commentCnt) {
		super();
		this.commentCnt = commentCnt;
	}

	public int getCommentCnt() {
		return commentCnt;
	}

	public void setCommentCnt(int commentCnt) {
		this.commentCnt = commentCnt;
	}

	@Override
	public String toString() {
		return "BoardForList [commentCnt=" + commentCnt + ", toString()=" + super.toString() + "]";
	}

}
