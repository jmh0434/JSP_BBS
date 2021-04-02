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
			String dbURL = "jdbc:mysql://localhost:3306/bbs?serverTimezone=Asia/Seoul&useSSL=false&useUnicode=true&characterEncoding=UTF-8";
			String dbID = "root";
			String dbPassword = "root";
			Class.forName("com.mysql.jdbc.Driver");	// Driver 라이브러리
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
	}
	
	// 로그인을 하는 함수
	public int login(String userID, String userPassword)
	{
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?";
		try
		{
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  userID);		// SQL 인젝션 해킹 방어 ??
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				if(rs.getString(1).equals(userPassword))
					return 1;	// 로그인 성공
				else
					return 0;	// 비밀번호 틀림
			}
			return -1;	// 아이디가 없음
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		return -2; // 데이터베이스 오류
	}
	
	// 회원가입을 하는 함수
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
		return -1; 	// 데이터베이스 오류
	}
	
	
	// 아이디를 찾는 함수
	public String findID(String userName, String userEmail)
	{
		// userName으로 해당하는 userEmail를 select 하는 SQL
		String SQL = "SELECT userID FROM USER WHERE userName = ? AND userEmail = ?";

		try
		{
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userName);
			pstmt.setString(2, userEmail);
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				return rs.getString(1);	// rs는 첫 번째가 1이다;; (0부터 시작을 안한다)
			}
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;	// 만약에 이름이나 이메일이 틀렸다면 null 반환
	}
	
	// 비밀번호를 찾는 함수
	public int findPwd(String userID, String userEmail)
	{
		// USER 테이블에 userID와 userEmail 둘 다 맞는 데이터가 존재하는지 확인
		String SQL = "SELECT * FROM USER WHERE userID = ? AND userEmail = ?";	
		try	
		{
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  userID);		
			pstmt.setString(2, userEmail);
			rs = pstmt.executeQuery();
			if (rs.next())
				return 1; // 해당하는 데이터가 존재
			else
				return -1;	// 해당하는 데이터가 존재 X
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		return -2; // 데이터베이스 오류
	}
		
	// 비빌번호를 바꾸는 함수
	public int changePwd(String userPassword, String userID)
	{
		String SQL = "UPDATE USER SET userPassword = ? WHERE userID = ?";
		try
		{
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userPassword);
			pstmt.setString(2, userID);
			return pstmt.executeUpdate();	// INSERT / DELETE / UPDATE 관련 구문에서는 반영된 레코드의 건수를 반환
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		return -1; 	// 데이터베이스 오류
	}
}
