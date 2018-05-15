Select the correct gender when the variable name is in the data vvaluex

Nice example of vvaluex.

Same result WPS/SAS.

I have a  messy dataset where gender is
correct for only the name given in
the friend column. I need to create a new
variable with the correct gender.

githib
https://tinyurl.com/ybuox59k
https://github.com/rogerjdeangelis/utl_select_the_correct_gender_when_the_variable_name_is_in_the_data_vvaluex

see
https://tinyurl.com/ycexskyo
https://communities.sas.com/t5/Base-SAS-Programming/Variable-values-into-variable-names/m-p/462265

FredrikE profile
https://communities.sas.com/t5/user/viewprofilepage/user-id/13827


INPUT
=====

The name in friend determines which varible has the correct gender.

                                            RULES
                                         |
SEX_TED    SEX_MAX    SEX_LIZ    FRIEND  |  SEX
                                         |
   M                     U        TED    |   M    * variable SEX_TED is correct
              M                   MAX    |   M
   U          ?          F        LIZ    |   F
                                         |


PROCESS
=======

data want;
 set have;
 sex = vvaluex(cats('SEX_',friend));
run;quit;


OUTPUT
======

WORK.WANT total obs=3

Obs    SEX_TED    SEX_MAX    SEX_LIZ    FRIEND    SEX

 1        M                     U        TED       M
 2                   M                   MAX       M
 3        U          ?          F        LIZ       F

*                _               _       _
 _ __ ___   __ _| | _____     __| | __ _| |_ __ _
| '_ ` _ \ / _` | |/ / _ \   / _` |/ _` | __/ _` |
| | | | | | (_| |   <  __/  | (_| | (_| | || (_| |
|_| |_| |_|\__,_|_|\_\___|   \__,_|\__,_|\__\__,_|

;


data have;
  input (SEX_TED SEX_MAX SEX_LIZ FRIEND) ($);
cards4;
M . U TED
. M . MAX
U ? F LIZ
;;;;
run;quit;

*          _       _   _
 ___  ___ | |_   _| |_(_) ___  _ __
/ __|/ _ \| | | | | __| |/ _ \| '_ \
\__ \ (_) | | |_| | |_| | (_) | | | |
|___/\___/|_|\__,_|\__|_|\___/|_| |_|

;

* SAS - see process;

%utl_submit_wps64('
libname wrk sas7bdat "%sysfunc(pathname(work))";
data want;
 set wrk.have;
 sex = vvaluex(cats("SEX_",friend));
run;quit;
proc print;
run;quit;
');


