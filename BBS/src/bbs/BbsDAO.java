package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO {
	
	private Connection conn;
	private ResultSet rs;
	
	//�⺻ ������
	public BbsDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/bbs?serverTimezone=Asia/Seoul&useSSL=false&useUnicode=true&characterEncoding=UTF-8";
			String dbID = "root";
			String dbPassword = "root";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//�ۼ����� �޼ҵ�
	public String getDate() {
		String sql = "select now()";
		try {
				PreparedStatement pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					return rs.getString(1);
				}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "";//�����ͺ��̽� ����
	}
	
	//�Խñ� ��ȣ �ο� �޼ҵ�
	public int getNext() {
		//���� �Խñ��� ������������ ��ȸ�Ͽ� ���� ������ ���� ��ȣ�� ���Ѵ�
		String sql = "select bbsID from BBS order by bbsID desc";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1)+1;
			}
			return 1; //ù ��° �Խù��� ���
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //�����ͺ��̽� ����
	}
	
	
	public int like(String bbsTitle) {
		PreparedStatement pstmt = null;
	        try {
			String SQL = "UPDATE bbs SET likeCount = likeCount + 1 WHERE bbsTitle = ?";
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, bbsTitle);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -1;
	}

	//�۾��� �޼ҵ�
	public int write(String bbsTitle, String userID, String bbsContent) {
		String SQL = "INSERT INTO bbs (bbsID, bbsTitle, userID, bbsDate, bbsContent, bbsAvailable) VALUES(?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, bbsTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, bbsContent);
			pstmt.setInt(6, 1); //���� ��ȿ��ȣ
			return pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //�����ͺ��̽� ����	
	}


	//�Խñ� ����Ʈ �޼ҵ�
	public ArrayList<Bbs> getList(int pageNumber){//���� �������� �Խñ� ����� ����Ʈ ���·� �޾ƿ´�
		//��� �Խñ��� ��ȸ�Ѵ�. ���� ��ȿ��ȣ�� �����ϰ� ���Ӱ� �ۼ��� �Խñ� ��ȣ���� ���� ��� �Խñ۹�ȣ�� �������� ���ķ� �ִ� 10������ ��ȸ
		String sql = "select * from bbs where bbsID < ? and bbsAvailable = 1 order by bbsID desc limit 10";
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,  getNext()-(pageNumber-1)*10);
			rs=pstmt.executeQuery();
			while(rs.next()) {//������� �����ϴ� ���� ������ ��Ҹ� ���� ��� �ϳ��� ����Ʈ�� �ϼ��Ͽ� 'getList'�� 'return'
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				bbs.setLikeCount(rs.getInt(7));
				list.add(bbs);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
			
	}
	
	//����¡ ó�� �޼ҵ� (Ư���� �������� �����ϴ��� ��ȸ�ϴ� �޼ҵ�/ �Խñ��� 10������ 11���� �Ѿ �� '����'��ư�� ����� ����¡ ó��)
	public boolean nextPage(int pageNumber) {
		String sql = "select * from bbs where bbsID <? and bbsAvailable = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext()-(pageNumber-1)*10);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	//�ϳ��� �Խñ��� ���� �޼ҵ�
	public Bbs getBbs(int bbsID) {
		String sql = "select * from bbs where bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bbsID);
			rs= pstmt.executeQuery();
			if(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				bbs.setLikeCount(rs.getInt(7));
				return bbs;
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	//�Խñ� ���� �޼ҵ�
	public int update(int bbsID, String bbsTitle, String bbsContent) {
		String sql = "update bbs set bbsTitle = ?, bbsContent = ? where bbsID=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bbsTitle);
			pstmt.setString(2, bbsContent);
			pstmt.setInt(3, bbsID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	//�Խñ� ���� �޼ҵ�
	public int delete(int bbsID) {
		//���� �����͸� �����ϴ� ���� �ƴ϶� �Խñ� ��ȿ���ڸ� 0���� �����Ѵ�.
		String sql = "update bbs set bbsAvailable = 0 where bbsID=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,bbsID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
}
