package ui;

import java.awt.EventQueue;
import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Properties;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JSeparator;
import javax.swing.JTextArea;
import javax.swing.JTextField;

import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;

import javax.swing.JTable;

import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;

import javax.swing.JScrollPane;

import model.ResultModel;

public class QueryAnalyzerForm {

	private Connection cn;
	private String url;
	private String driver;
	private String username;
	private String password;
	private String firstQuery;
	
	private JTextField txtUrl;
	private JFrame frmQueryAnalyzer;
	private JTextArea txtQuery;
	private JTextField txtUsername;
	private JTextField txtPassword;
	private JButton btnConnect;
	
	PreparedStatement ps; 
	Statement stScroll;
	private JButton btnExecute;
	private JButton btnClear;
	private JTable table;
	ResultModel rm;
	private JScrollPane queryScroll;
	private JScrollPane resultScroll;
	
	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					QueryAnalyzerForm window = new QueryAnalyzerForm();
					window.frmQueryAnalyzer.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}

	/**
	 * Create the application.
	 */
	public QueryAnalyzerForm() {
		getDBProperties();
		initialize();
	}

	private void getDBProperties() {
		String propertiesURI = 
				this.getClass().getResource("").getPath() + "database.properties";
		Properties pr = new Properties();
		try {
			FileInputStream fis = new FileInputStream(propertiesURI);
			pr.load(fis);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		url = pr.getProperty("url");
		username = pr.getProperty("username");
		password = pr.getProperty("password");
		driver = pr.getProperty("driver");
		firstQuery = pr.getProperty("first");
	}

	/**
	 * Initialize the contents of the frame.
	 */
	private void initialize() {
		frmQueryAnalyzer = new JFrame();
		frmQueryAnalyzer.setTitle("SELECT Analyzer");
		frmQueryAnalyzer.setBounds(100, 100, 700, 400);
		frmQueryAnalyzer.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frmQueryAnalyzer.getContentPane().setLayout(null);
		
		JSeparator separator = new JSeparator();
		separator.setBounds(12, 35, 660, 13);
		frmQueryAnalyzer.getContentPane().add(separator);
		
		txtUrl = new JTextField();
		txtUrl.setBounds(33, 11, 247, 21);
		frmQueryAnalyzer.getContentPane().add(txtUrl);
		txtUrl.setText(url);
		txtUrl.setColumns(10);
		
		JLabel lblIp = new JLabel("url");
		lblIp.setBounds(12, 14, 57, 15);
		frmQueryAnalyzer.getContentPane().add(lblIp);
		
		txtUsername = new JTextField();
		txtUsername.setBounds(357, 11, 80, 21);
		frmQueryAnalyzer.getContentPane().add(txtUsername);
		txtUsername.setColumns(10);
		
		txtPassword = new JTextField();
		txtPassword.setBounds(514, 11, 80, 21);
		frmQueryAnalyzer.getContentPane().add(txtPassword);
		txtPassword.setColumns(10);
		
		JLabel lblUsername = new JLabel("username");
		lblUsername.setBounds(292, 14, 64, 15);
		frmQueryAnalyzer.getContentPane().add(lblUsername);
		
		JLabel lblPassword = new JLabel("password");
		lblPassword.setBounds(449, 14, 64, 15);
		frmQueryAnalyzer.getContentPane().add(lblPassword);
		
		txtUsername.setText(username);
		txtPassword.setText(password);
		btnConnect = new JButton("\uC5F0\uACB0");
		
		btnConnect.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent ae) {
				try{
					Class.forName(driver);
					cn = DriverManager.getConnection(
						txtUrl.getText(), txtUsername.getText(), txtPassword.getText());

					stScroll = cn.createStatement(
						ResultSet.TYPE_SCROLL_SENSITIVE,
						ResultSet.CONCUR_UPDATABLE
					);	
					JOptionPane.showMessageDialog(null, "연결되었습니다.");
					
					btnConnect.setEnabled(false);
					txtQuery.setEnabled(true);
					btnClear.setEnabled(true);
					btnExecute.setEnabled(true);
					
					txtQuery.setText(firstQuery);
					btnExecute.doClick();
					txtQuery.requestFocus();
					
				}catch(Exception e){
					e.printStackTrace();
					JOptionPane.showMessageDialog(null, "연결에러입니다.\n" + e.getMessage());
				}
			}
		});
		
		btnConnect.setBounds(602, 10, 70, 23);
		frmQueryAnalyzer.getContentPane().add(btnConnect);
		
		btnExecute = new JButton("execute");
		btnExecute.setEnabled(false);
		btnExecute.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				Object obj = e.getSource();
				if (obj == btnExecute) { 				//ok버튼 눌렀을 때
					execute();
				}
			}

			public void execute() {
				try{
					if(txtQuery.getText().trim().equals("")){	
						JOptionPane.showMessageDialog(null, "쿼리문을 써주세요");
						return;
					}
					
					String sql = txtQuery.getText().trim();		//Query문 trim
					
					if((sql.charAt(sql.length()-1))==';'){		//문장 맨 끝에 ";" 삭제
						sql = sql.substring(0, sql.length()-1);
					}
					
					rm = new ResultModel();					
					ps = cn.prepareStatement(sql);
					
					//쿼리 수행 및 결과 출력
					ResultSet rsScroll = stScroll.executeQuery(sql);
					ResultSet rs = ps.executeQuery();
					rm.getRowCount(rsScroll);	//데이터 갯수 가져오기
					rm.setData(rs);				//데이터 받아오기
					table.setModel(rm);			//테이블에 데이터 넣기
					table.updateUI();			//테이블에 있는 데이터 뿌리기
				}catch(Exception e){
					JOptionPane.showMessageDialog(null, "쿼리 실행 오류입니다.\n" + e.getMessage());
				}
			}
		});
		btnExecute.setBounds(575, 139, 97, 23);
		frmQueryAnalyzer.getContentPane().add(btnExecute);
		
		btnClear = new JButton("clear");
		btnClear.setEnabled(false);
		btnClear.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent ae) {
				txtQuery.setText("");
				txtQuery.requestFocus();
			}
		});
		btnClear.setBounds(478, 139, 97, 23);
		frmQueryAnalyzer.getContentPane().add(btnClear);
		
		queryScroll = new JScrollPane();
		queryScroll.setBounds(12, 46, 660, 88);
		frmQueryAnalyzer.getContentPane().add(queryScroll);
		
		txtQuery = new JTextArea();
		queryScroll.setViewportView(txtQuery);
		txtQuery.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent me) {
				notConnect();
			}
		});
		txtQuery.setEnabled(false);
		txtQuery.setColumns(10);
		
		resultScroll = new JScrollPane();
		resultScroll.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent arg0) {
				notConnect();
			}
		});
		resultScroll.setBounds(12, 167, 660, 184);
		frmQueryAnalyzer.getContentPane().add(resultScroll);
		
		table = new JTable();
		resultScroll.setViewportView(table);
	}

	protected void notConnect() {
		if (cn == null) {
			JOptionPane.showMessageDialog(null, "먼저 데이터베이스에 연결하세요");
			btnConnect.requestFocus(true);
		}
	}
}
