ame=COMMANDS
simulator=ngspice
only_toplevel=false 
value="
.control
op
save all
set appendweite
AC DEC 100 1 10e6
write miCTest.raw

MEAS AC gain_db MAX vdb(vout) FROM=1 TO=10e6
LET vm3db = gain_db3.0
print vm3db
MEAS AC fzero WHEN vdb(vout)=vm3db RISE=1
MEAS AC fpole WHEN vdb(vout)=vm3db FALL=1
MEAS AC fmid WHEN vdb(vout)=gain_db
**Phase Measurment
LET phase_deg = cph(vout)*180/PI
MEAS AC phase_zero FIND phase_deg AT=fzero
MEAS AC phase_pole FIND phase_deg AT=fpole
MEAS AC phase_mid FIND phase_deg AT=fmid
**MEAS fzero and fpole using phase
LET phase_zero_ph = phase_mid-45
MEAS AC fzero_ph WHEN phase_deg=phase_zero_ph

.endc
"
