using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading;
using System.Windows.Forms;
using System.IO.Ports;

namespace WeatherClickMonitor
{   
    public partial class Form1 : Form
    {
        SerialPort sp = new SerialPort();
        public delegate void myDelegate();

        StringBuilder builder = new StringBuilder();


        public Form1()
        {
            InitializeComponent();
        }

        private void btnSearch_Click(object sender, EventArgs e)
        {
            sp.DataReceived += new SerialDataReceivedEventHandler(DataReceived);

            string[] portNames = SerialPort.GetPortNames();
            for (int i = 0; i < portNames.Length; i++)
            {
                cbbPort.Items.Add(portNames[i]);
            }
            btnDisconnect.Enabled = false;
            btnDisconnect.Enabled = false;
            btnDisconnect.Enabled = false;
            btnDisconnect.Enabled = false;

            cbbPort.SelectedIndex = 0;
        }

        private void btnConnect_Click(object sender, EventArgs e)
        {
            if (sp.IsOpen)
            {
                sp.Close();
            }
            try
            {
                sp.PortName = cbbPort.Text;                
                sp.BaudRate = Convert.ToInt32(cbbBaud.Text);                
                sp.DataBits = Convert.ToInt32(cbbDataBits.Text);                
                sp.StopBits = (System.IO.Ports.StopBits)Enum.Parse(typeof(System.IO.Ports.StopBits), cbbStopBits.Text);                 
                sp.Parity = (System.IO.Ports.Parity)Enum.Parse(typeof(System.IO.Ports.Parity), cbbParityBits.Text);
                
                sp.Open();

                lblStatus.Text = cbbPort.Text + " connected";
                btnConnect.Enabled = false;
                btnDisconnect.Enabled = true;
            }
            catch (Exception ex)
            {
                //MessageBox.Show(ex.ToString());
                MessageBox.Show("COM Port is not selected!!!");
            }
        }

        private void btnDisconnect_Click(object sender, EventArgs e)
        {
            try
            {
                sp.Close();
                lblStatus.Text = sp.PortName + " disconnected";
                btnConnect.Enabled = true;
                btnDisconnect.Enabled = false;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString());
            }
        }

        private void DataReceived(object sender, System.IO.Ports.SerialDataReceivedEventArgs e)
        {               
            lblTemp.BeginInvoke(new myDelegate(updateThread));
        }             

        public void updateThread()
        {
            Thread th2 = new Thread(update);
            th2.Start();
        }
        void update()
        {
            this.Invoke(new MethodInvoker(delegate ()
            {
                string sdata;
                string temp_data, press_data, hum_data;
                bool t_con, p_con, h_con;
                int i_temp, i_press, i_hum;
                int len;

                sdata = sp.ReadLine();

                t_con = sdata.Contains("T");
                p_con = sdata.Contains("P");
                h_con = sdata.Contains("H");                

                if (t_con)
                {
                    len = sdata.Length;
                    i_temp = sdata.IndexOf("T", 0, len);
                    temp_data = sdata.Substring(i_temp - 5, 5);
                    lblTemp.Text = temp_data;
                }

                if (p_con)
                {
                    len = sdata.Length;
                    i_press = sdata.IndexOf("P", 0, len);
                    press_data = sdata.Substring(i_press - 7, 7);
                    lblPress.Text = press_data;
                }

                if (h_con)
                {
                    len = sdata.Length;
                    i_hum = sdata.IndexOf("H", 0, len);
                    hum_data = sdata.Substring(i_hum - 5, 5);
                    lblHum.Text = hum_data;
                }

            }
            ));

        }

        private void Form1_Load(object sender, EventArgs e)
        {
            btnDisconnect.Enabled = false;
        }

        private void Form1_FormClosing(object sender, FormClosingEventArgs e)
        {
            if (sp.IsOpen)
            {
                sp.Close();
            }
        }
    }
}
