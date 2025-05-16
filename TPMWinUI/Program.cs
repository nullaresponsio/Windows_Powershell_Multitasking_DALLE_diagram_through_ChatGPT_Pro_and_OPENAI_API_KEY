// TPMWinUI/Program.cs
using System;
using System.Windows.Forms;

namespace TPMWinUI
{
    static class Program
    {
        [STAThread]
        static void Main()
        {
            if (!TpmHelper.IsTpmReady())
            {
                MessageBox.Show("TPM attestation failed. Application will exit.", "TPM Error",
                    MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.Run(new MainForm());
        }
    }
}
