package library.management.repositories;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import library.management.entities.UpcomingEvent;

public class UpcomingEventRowMapper implements RowMapper<UpcomingEvent>{

	@Override
	public UpcomingEvent mapRow(ResultSet rs, int rowNum) throws SQLException {
		UpcomingEvent events = new UpcomingEvent();
		events.setUpComingEventId(rs.getInt("eventId"));
		events.setUpcomingEventDetail(rs.getString("eventDetail"));
		events.setUpcomingEventDate(rs.getDate("eventDate"));
		return events;
	}

}
