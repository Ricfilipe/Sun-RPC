# This Makefile was originally generated by rpcgen
# but was modified to delete t_client.c and t_server.c from TARGETS
# to add -pthread flag

# Parameters

CLIENT = ttt_client
SERVER = ttt_server
EXAMPLE = local

SOURCES_CLNT.c =
SOURCES_CLNT.h =
SOURCES_SVC.c = ttt_lib.c
SOURCES_SVC.h = ttt_lib.h
SOURCES.x = ttt.x
SOURCES_EXAMPLE.c = local_main.c $(SOURCES_SVC.c)

TARGETS_SVC.c = ttt_svc.c ttt_server.c ttt_xdr.c
TARGETS_CLNT.c = ttt_clnt.c ttt_client.c ttt_xdr.c
TARGETS = ttt.h ttt_xdr.c ttt_clnt.c ttt_svc.c

OBJECTS_CLNT = $(SOURCES_CLNT.c:%.c=%.o) $(TARGETS_CLNT.c:%.c=%.o)
OBJECTS_SVC = $(SOURCES_SVC.c:%.c=%.o) $(TARGETS_SVC.c:%.c=%.o)
OBJECTS_EXAMPLE = $(SOURCES_EXAMPLE.c:%.c=%.o)

# Compiler flags

CFLAGS += -g
LDLIBS += -lnsl -pthread
RPCGENFLAGS =

# Targets

all : $(CLIENT) $(SERVER) $(EXAMPLE)

$(TARGETS) : $(SOURCES.x)
	rpcgen $(RPCGENFLAGS) $(SOURCES.x)

$(OBJECTS_CLNT) : $(SOURCES_CLNT.c) $(SOURCES_CLNT.h) $(TARGETS_CLNT.c)

$(OBJECTS_SVC) : $(SOURCES_SVC.c) $(SOURCES_SVC.h) $(TARGETS_SVC.c)

$(OBJECTS_EXAMPLE) : $(SOURCES_EXAMPLE.c) $(SOURCES_SVC.h)

$(CLIENT) : $(OBJECTS_CLNT)
	$(LINK.c) -o $(CLIENT) $(OBJECTS_CLNT) $(LDLIBS)

$(EXAMPLE) : $(OBJECTS_EXAMPLE)
	$(LINK.c) -o $(EXAMPLE) $(OBJECTS_EXAMPLE)

$(SERVER) : $(OBJECTS_SVC)
	$(LINK.c) -o $(SERVER) $(OBJECTS_SVC) $(LDLIBS)

 clean:
	 $(RM) core $(TARGETS) $(OBJECTS_CLNT) $(OBJECTS_SVC) $(CLIENT) $(SERVER)

