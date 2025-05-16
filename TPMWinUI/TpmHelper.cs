// TPMWinUI/TpmHelper.cs
using System.Management;

namespace TPMWinUI
{
    public static class TpmHelper
    {
        public static bool IsTpmReady()
        {
            try
            {
                var q = new ManagementObjectSearcher(
                    @"root\CIMV2\Security\MicrosoftTpm",
                    "SELECT IsEnabled_InitialValue,IsOwned_InitialValue FROM Win32_Tpm");

                foreach (ManagementObject tpm in q.Get())
                {
                    bool enabled = (bool)tpm["IsEnabled_InitialValue"];
                    bool owned   = (bool)tpm["IsOwned_InitialValue"];
                    if (enabled && owned) return true;
                }
            }
            catch { }
            return false;
        }
    }
}
