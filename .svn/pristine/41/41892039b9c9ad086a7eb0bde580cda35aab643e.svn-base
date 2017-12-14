package model;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;

import javax.swing.table.AbstractTableModel;

public class ResultModel extends AbstractTableModel {
	Object[][] data;
	String [] columnName; //column heading
	
	int rows, cols; 		
	
	@Override
	public int getColumnCount() {		
		return columnName.length;
	}

	@Override
	public int getRowCount() {
		return data.length;
	}
	
	@Override
	public Object getValueAt(int rowIndex, int columnIndex) {
		return data[rowIndex][columnIndex];
	}

	@Override
	public String getColumnName(int column) {
		return columnName[column];
	}
	
	public void getRowCount(ResultSet rsScroll){
		try{
			rsScroll.last();
			rows = rsScroll.getRow();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public void setData(ResultSet rs){
		try{
			ResultSetMetaData rsmd;	
			rsmd = rs.getMetaData();
			
			cols = rsmd.getColumnCount();
			data = new Object[rows][cols];
			
			columnName = new String[cols];
			
			for(int i=0; i<rsmd.getColumnCount(); i++){
				columnName[i] = rsmd.getColumnName(i+1);				
			}
			
			for(int i=0; i<cols; i++){
				columnName[i] = getColumnName(i);
			}
			
			int r = 0;	
			while(rs.next()){
				for(int c=0; c<cols; c++){
					if(c != 1) {	//데이터 출력
						data[r][c] = rs.getObject(c + 1);	//배열은 0부터 시작, ResultSet은 1부터 시작
					} else {		//컬럼이름 출력
						data[r][c] = (String)rs.getObject(c + 1);
					}
				}
				r++;
			}
		} catch(Exception e){
			e.printStackTrace();
		} finally{
			if(rs != null) try{rs.close();}catch(Exception e){}
		}
	}
}


