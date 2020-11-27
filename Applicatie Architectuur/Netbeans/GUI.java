import java.awt.Container;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JTextField;

public class GUI extends JFrame implements ActionListener{
    
    private JTextField tf = new JTextField(8);
    private JLabel l = new JLabel("totprijs");

    public GUI()
    {   
        Container c = this.getContentPane();
        c.setLayout(new GridLayout(2,0));
        c.add(new JLabel("Dagen:"));
        c.add(tf);
        c.add(l);
        tf.addActionListener(this);
        this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        this.pack();
        this.setVisible(true);     
    }
    
     public void actionPerformed(ActionEvent ae)
    {
       .... // nog aan te vullen
    }
    
}