package booking.model.vo;

public class BookingCount {
	
	private int total;
	private int approval;
	private int finish;
	private int cancle;
	
	public BookingCount() {
		super();
	}

	public BookingCount(int total, int approval, int finish, int cancle) {
		super();
		this.total = total;
		this.approval = approval;
		this.finish = finish;
		this.cancle = cancle;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public int getApproval() {
		return approval;
	}

	public void setApproval(int approval) {
		this.approval = approval;
	}

	public int getFinish() {
		return finish;
	}

	public void setFinish(int finish) {
		this.finish = finish;
	}

	public int getCancle() {
		return cancle;
	}

	public void setCancle(int cancle) {
		this.cancle = cancle;
	}

	@Override
	public String toString() {
		return "total=" + total + ", approval=" + approval + ", finish=" + finish + ", cancle=" + cancle;
	}
	
	
	
	

}
