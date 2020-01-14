tscale= -timescale="1ns/1ps"

SNPS_SOFT_HOME = /usr/synopsys/soft
UVM_HOME = ${SNPS_SOFT_HOME}/code/uvm-1.1d
uvm_incdir =+incdir+${UVM_HOME}/src+${UVM_HOME}/src/vcs

#reserved
uvm_comp_option=+define+SIMPLE_COV_MODE

VERBOSITY=UVM_HIGH 

uvm_file = ${UVM_HOME}/src/uvm_pkg.sv
UVM_COMPILE = ${UVM_HOME}/src/dpi/uvm_dpi.cc \
    ${uvm_file}\
    -CFLAGS \
    -DVCS \
    $(uvm_incdir) \
    $(uvm_comp_option)

tb  = -f ./filelist.f

lib =   

tc  ?=

tc_prefix = $(basename $(tc))

RUN_OPTION = +UVM_TESTNAME=$(tc) +UVM_VERBOSITY=$(VERBOSITY) 

#tc_name_v = ../tc/$(tc_prefix).v
#tc_name_sv = ../tc/$(tc_prefix).sv 
#
#exist_sv = $(shell if [ -f $(tc_name_sv) ]; then echo "exist"; else echo "not_exist"; fi;)
#ifeq ($(exist_sv),exist)
#tc_name = $(tc_name_sv)
#else
#tc_name = $(tc_name_v)
#endif

fsdb = test.fsdb
runtime = $(shell date +"%Y%m%d%H%M%S")

seed = $$$$ 

all: clean comp running check



cov = 1
reg = 0

ifeq ($(strip $(cov)),1)
    ifeq ($(strip $(reg)),1)
        cov_cmp_vcs = -cm line+cond+fsm+tgl+branch+assert -cm_dir ./cov/cmp_cov
        cov_sim_vcs = -cm line+cond+fsm+tgl+branch+assert -cm_dir ./cov/cov$(tc_prefix)_$(runtime) -cm_name $(tc_prefix)
        cov_files = cov.vdb DVEfiles novas* ./cov *.vdb urg*
    else
        cov_cmp_vcs = -cm line+cond+fsm+tgl+branch+assert -cm_dir ./cov
        cov_sim_vcs = -cm line+cond+fsm+tgl+branch+assert -cm_dir ./cov -cm_name $(tc_prefix)
        cov_files = cov.vdb DVEfiles novas*
    endif
else
    cov_cmp_vcs =
    cov_sim_vcs = 
endif

clean:
	rm -rf simv* csrc *.log vc_hdrs.h ucli.key $(cov_files)

dve_cov:
	dve -full64 -lca -cov -covdir ./cov.vdb

comp:
	vcs -sverilog -full64 -LDFLAGS -Wl,--no-as-needed -debug_all $(tscale) $(lib) $(UVM_COMPILE) $(cov_cmp_vcs) $(tb) -l comp.log \
            -P ${SNPS_SOFT_HOME}/verdi/Verdi3_L-2016.06-1/share/PLI/VCS/LINUX64/novas.tab \
               ${SNPS_SOFT_HOME}/verdi/Verdi3_L-2016.06-1/share/PLI/VCS/LINUX64/pli.a

running:
	./simv +ntb_random_seed=$(shell echo "$(seed)") $(cov_sim_vcs) $(RUN_OPTION) -l run.log

check:
	grep -c "ERROR" run.log | cat

ls:
	@cd ../tc; ls

verdi:
	verdi -ssv -ssy -sv $(UVM_COMPILE) $(tb) $(lib) -ssf $(fsdb)

###add cmd for regression ####
#TESTS :=drt_wr_rd_mem_test rand_wr_rd_mem_test err_wr_rd_mem_test
testcase =caselist.txt
TESTS = $(shell cat $(testcase))
regress:
	@$(foreach tc,$(TESTS),\
		./simv +ntb_random_seed=$(shell echo "$(seed)") $(RUN_OPTION) ${cov_sim_vcs} -l $(tc).log;\
	)
	urg -full64 -metric line+cond+fsm+tgl+branch+assert+group -parallel -dbname cov.vdb -dir ./cov/*.vdb
	dve -full64 -lca -cov -covdir ./cov.vdb

