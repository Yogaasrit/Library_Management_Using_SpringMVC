package library.management.entities;

import java.sql.Date;

public class UpcomingEvent {
	private int upComingEventId;
	private String upcomingEventDetail;
	private Date upcomingEventDate;
	public int getUpComingEventId() {
		return upComingEventId;
	}
	public void setUpComingEventId(int upComingEventId) {
		this.upComingEventId = upComingEventId;
	}
	public String getUpcomingEventDetail() {
		return upcomingEventDetail;
	}
	public void setUpcomingEventDetail(String upcomingEventDetail) {
		this.upcomingEventDetail = upcomingEventDetail;
	}
	public Date getUpcomingEventDate() {
		return upcomingEventDate;
	}
	public void setUpcomingEventDate(Date upcomingEventDate) {
		this.upcomingEventDate = upcomingEventDate;
	}
	public UpcomingEvent() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
}
