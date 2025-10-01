{ config, pkgs, ... }:
{
services.tlp = {
  enable = true;
  settings = {
      # Change CPU energy/performance policy
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

      # Enable the platform profiler
      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "low-power";

      # Disable turbo boost
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;

      CPU_HWP_DYN_BOOST_ON_AC = 1;
      CPU_HWP_DYN_BOOST_ON_BAT = 0;

      # Reduce power consumption / fan noice on AC power
      RUNTIME_PM_ON_AC = "auto";
      RUNTIME_PM_ON_BAT = "auto";

      # Limit power consumption under high CPU load
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MAX_PERF_ON_BAT = 25;
  };
};
}
