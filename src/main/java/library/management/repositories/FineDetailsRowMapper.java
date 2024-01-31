package library.management.repositories;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import library.management.entities.FineDetails;

public class FineDetailsRowMapper implements RowMapper<FineDetails> {

	@Override
	public FineDetails mapRow(ResultSet rs, int rowNum) throws SQLException {
		FineDetails details = new FineDetails();
		details.setBorrowedId(rs.getInt("borrowedId"));
		details.setFineAmount(rs.getInt("bookFine"));
		return details;
	}

}
