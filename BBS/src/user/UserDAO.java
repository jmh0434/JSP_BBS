package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


public class UserDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO()
	{
		try 
		{
			String dbURL = "jdbc:mysql://localhost:3306/bbs";
			String dbID = "root";
			String dbPassword = "root";
			Class.forName("com.mysql.jdbc.Driver");	// Driver ���̺귯��
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
	}
	
	// �α����� �ϴ� �Լ�
	public int login(String userID, String userPassword)
	{
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?";
		try
		{
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  userID);		// SQL ������ ��ŷ ��� ??
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				if(rs.getString(1).equals(userPassword))
					return 1;	// �α��� ����
				else
					return 0;	// ��й�ȣ Ʋ��
			}
			return -1;	// ���̵� ����
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		return -2; // �����ͺ��̽� ����
	}
	
	// ȸ�������� �ϴ� �Լ�
	public int join(User user)
	{
		String SQL = "INSERT INTO USER VALUES(?, ?, ?, ?, ?)";
		try
		{
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setString(5, user.getUserEmail());
			return pstmt.executeUpdate();
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		return -1; 	// �����ͺ��̽� ����
	}
	
	
	// ���̵� ã�� �Լ�
	public String findID(String userName, String userEmail)
	{
		// userName���� �ش��ϴ� userEmail�� select �ϴ� SQL
		String SQL = "SELECT userID FROM USER WHERE userName = ? AND userEmail = ?";

		try
		{
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userName);
			pstmt.setString(2, userEmail);
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				return rs.getString(1);	// rs�� ù ��°�� 1�̴�;; (0���� ������ ���Ѵ�)
			}
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;	// ���࿡ �̸��̳� �̸����� Ʋ�ȴٸ� null ��ȯ
	}
	
	// ��й�ȣ�� ã�� �Լ�
	public int findPwd(String userID, String userEmail)
	{
		// USER ���̺� userID�� userEmail �� �� �´� �����Ͱ� �����ϴ��� Ȯ��
		String SQL = "SELECT * FROM USER WHERE userID = ? AND userEmail = ?";	
		try	
		{
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  userID);		
			pstmt.setString(2, userEmail);
			rs = pstmt.executeQuery();
			if (rs.next())
				return 1; // �ش��ϴ� �����Ͱ� ����
			else
				return -1;	// �ش��ϴ� �����Ͱ� ���� X
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		return -2; // �����ͺ��̽� ����
	}
		
	// �����ȣ�� �ٲٴ� �Լ�
	public int changePwd(String userPassword, String userID)
	{
		String SQL = "UPDATE USER SET userPassword = ? WHERE userID = ?";
		try
		{
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userPassword);
			pstmt.setString(2, userID);
			return pstmt.executeUpdate();	// INSERT / DELETE / UPDATE ���� ���������� �ݿ��� ���ڵ��� �Ǽ��� ��ȯ
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		return -1; 	// �����ͺ��̽� ����
	}
}
