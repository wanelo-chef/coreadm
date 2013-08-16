# %d Executable file directory name, up to a maximum of MAXPATHLEN characters
# %f Executable file name, up to a maximum of MAXCOMLEN characters
# %g Effective group-ID
# %m Machine name (uname -m)
# %n System node name (uname -n)
# %p Process-ID
# %t Decimal value of time(2)
# %u Effective user-ID
# %z Name of the zone in which process executed (zonename)
# %% Literal %

default['coreadm']['global_pattern'] = "coreadm -g /var/core/core.%f.%p.%t"
default['coreadm']['init_pattern'] = "coreadm -i /var/core/core.%f.%p.%t"