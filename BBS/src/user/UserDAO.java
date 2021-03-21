package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	
	private Connection conn; //�ڹٿ� �����ͺ��̽��� ����
	private PreparedStatement pstmt; //������ ��� �� ����
	private ResultSet rs; //����� �޾ƿ���
	
	//�⺻ ������
	//UserDAO�� ����Ǹ� �ڵ����� �����Ǵ� �κ�
	//�޼ҵ帶�� �ݺ��Ǵ� �ڵ带 �̰��� ������ �ڵ尡 ����ȭ�ȴ�
	public UserDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/bbs?useUnicode=true&characterEncoding=UTF-8";
			
			String dbID = "root";
			String dbPassword = "root";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	public int login(String userID, String userPassword) {
		String SQL = "select userPassword from user where userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL); //sql�������� ��� ��Ų��
			pstmt.setString(1, userID); //ù��° '?'�� �Ű������� �޾ƿ� 'userID'�� ����
			rs = pstmt.executeQuery(); //������ ������ ����� rs�� ����
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					return 1; //�α��� ����
				}else
					return 0; //��й�ȣ Ʋ��
			}
			return -1; //���̵� ����
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -2; //����
	}
	
	public int join(User user) {
		String SQL = "INSERT INTO USER (userID, userPassword, userName, userGender, userEmail) VALUES (?,?,?,?,?)"; //user ���̺��� �����͸� �Է��ϴ� ������ 
		try {
			pstmt = conn.prepareStatement(SQL); //sql �������� ����Ų��
			pstmt.setString(1, user.getUserID()); //1��° ����ǥ�� ���� ����ڰ� �Է��� userID ����
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setString(5, user.getUserEmail());
			return pstmt.executeUpdate(); //���������� �����Ͱ� �ԷµǾ��ٸ� �ݵ�� 1 �̻��� ���ڰ� ����
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //�����ͺ��̽� ����
				
	}
}
