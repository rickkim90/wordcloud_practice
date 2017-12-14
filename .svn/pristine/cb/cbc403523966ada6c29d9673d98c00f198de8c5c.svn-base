package ui;

import java.awt.EventQueue;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseAdapter;

import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;

import rcaller.RCaller;

public class RCallerAnalysis {
	private ImageIcon iic;
	private JFrame frame;
	private JLabel lblImage;
	private JButton btnCamus;
	private JButton btnHaruki;

	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					RCallerAnalysis window = new RCallerAnalysis();
					window.frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}

	public RCallerAnalysis() {
		initialize();
	}

	private void process(String target) {
		try{
            RCaller caller = new RCaller();
			caller.setRscriptExecutable("C:/Program Files/R/R-3.3.2/bin/x64/Rscript.exe");
			caller.addRCode("source(\"" + target + ".R\")");
            caller.runOnly();

    		ImageIcon iic = new ImageIcon(target + "_temp.png");
    		lblImage.setIcon(iic);

        }catch (Exception e){
            e.printStackTrace();
        }
	}

	private void initialize() {
		frame = new JFrame();
		frame.setBounds(100, 100, 540, 575);
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.getContentPane().setLayout(null);
		lblImage = new JLabel();
		lblImage.addMouseListener(new MouseAdapter() {});
		lblImage.setBounds(12, 10, 500, 466);
		frame.getContentPane().add(lblImage);
		
		btnCamus = new JButton("\uCE74\uBB88");
		btnCamus.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				process("camus");
				btnCamus.setText("�м��Ϸ�");
			}
		});
		btnCamus.setBounds(306, 486, 97, 23);
		frame.getContentPane().add(btnCamus);
		
		btnHaruki = new JButton("\uD558\uB8E8\uD0A4");
		btnHaruki.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				process("haruki");
				btnCamus.setText("�м��Ϸ�");
			}
		});
		btnHaruki.setBounds(415, 486, 97, 23);
		frame.getContentPane().add(btnHaruki);
	}
}
