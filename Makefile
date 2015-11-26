PROGRAM ?= backup_mysql
ETCDIR ?= /etc/$(PROGRAM)
BINDIR ?= /usr/sbin


all:
	@echo "please use make install or make uninstall"
	@echo "please use this Makefile with root"
	@echo $(USER)

install:
ifeq ($(USER),root)
	install -m 0700 -v -g 0 -o 0 "$(PROGRAM)" "$(BINDIR)/$(PROGRAM)"
	@echo ""	
	install -m 0700 -v -g 0 -o 0 "$(PROGRAM)_cron" "$(BINDIR)/$(PROGRAM)_cron"
	@echo ""	
	mkdir -p $(ETCDIR)
	@echo ""	
	[ -f "$(ETCDIR)/$(PROGRAM).ini" ] || \
		install -m 0700 -v -g 0 -o 0 "$(PROGRAM).ini" "$(ETCDIR)/$(PROGRAM).ini"
	
	@echo ""	
	@echo "*****************************************************************"
	@echo "the conf file is $(ETCDIR)/$(PROGRAM).ini"
	@echo "put $(BINDIR)/$(PROGRAM)_cron in your cron to schedule the script"
	@echo "*****************************************************************"
else
	@echo "please use this Makefile as root"
endif

move_ini:
	if [ -f "$(ETCDIR)/$(PROGRAM).ini" ] ; \
	then \
		mv "$(ETCDIR)/$(PROGRAM).ini" "$(ETCDIR)/$(PROGRAM).ini.old"; \
	fi

force-install: move_ini install

uninstall:
ifeq ($(USER),root)
	@rm -vrf \
		"$(DESTDIR)$(BINDIR)/$(PROGRAM)" \
		"$(DESTDIR)$(BINDIR)/$(PROGRAM)_cron" \
		"$(ETCDIR)"
else
	@echo "please use this Makefile as root"
endif

.PHONY: install uninstall all
