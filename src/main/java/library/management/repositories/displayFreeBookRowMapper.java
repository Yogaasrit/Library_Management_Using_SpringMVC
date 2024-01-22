package library.management.repositories;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import library.management.entities.FreeBook;

public class displayFreeBookRowMapper implements RowMapper<FreeBook>{
//	pdfId, pdfName, pdfAuthorName, pdf, pdfCover
	@Override
	public FreeBook mapRow(ResultSet rs, int rowNum) throws SQLException {
		FreeBook bookPdf = new FreeBook();
		bookPdf.setPdfName(rs.getString("pdfName"));
		bookPdf.setPdfId(rs.getInt("pdfId"));
		bookPdf.setPdfAuthorName(rs.getString("pdfAuthorName"));
		bookPdf.setPdfCover(rs.getBlob("pdfCover"));
		bookPdf.setPdf(rs.getBlob("pdf"));
		return bookPdf;
	}

}
