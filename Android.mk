LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE:= libobfsproxy
LOCAL_MODULE_TAGS:= optional

LOCAL_SRC_FILES :=                      \
    src/container.c			\
    src/crypt.c				\
    src/external.c			\
    src/main.c				\
    src/managed.c			\
    src/network.c			\
    src/protocol.c			\
    src/socks.c				\
    src/status.c			\
    src/util.c				\
    src/protocols/dummy.c		\
    src/protocols/obfs2.c

src/main.c: micro-revision.i

LOCAL_C_INCLUDES += external/libevent/include/
LOCAL_C_INCLUDES += external/openssl/include/
LOCAL_C_INCLUDES += $(LOCAL_PATH)/src/
LOCAL_C_INCLUDES += $(LOCAL_PATH)/src/protocols/

LOCAL_CFLAGS += -D_FORTIFY_SOURCE=2
LOCAL_CFLAGS += -DHAVE_CONFIG_H

include $(BUILD_STATIC_LIBRARY)




include $(CLEAR_VARS)

LOCAL_MODULE := obfsproxy
LOCAL_MODULE_TAGS := optional

LOCAL_SRC_FILES := src/obfs_main.c

LOCAL_STATIC_LIBRARIES := libobfsproxy libcrypto_static libevent_full

LOCAL_CFLAGS += -D_FORTIFY_SOURCE=2
LOCAL_CFLAGS += -DHAVE_CONFIG_H

include $(BUILD_EXECUTABLE)




#micro-revision.i: FORCE
#        @rm -f micro-revision.tmp;                                      \
#        if test -d "$(top_srcdir)/.git" &&                              \
#          test -x "`which git 2>&1;true`"; then                         \
#          HASH="`cd "$(top_srcdir)" && git rev-parse --short=16 HEAD`";         \
#          echo \"$$HASH\" > micro-revision.tmp;                         \
#        fi;                                                             \
#        if test ! -f micro-revision.tmp ; then                          \
#          if test ! -f micro-revision.i ; then                          \
#            echo '""' > micro-revision.i;                               \
#          fi;                                                           \
#        elif test ! -f micro-revision.i ||                              \
#          test x"`cat micro-revision.tmp`" != x"`cat micro-revision.i`"; then \
#          mv micro-revision.tmp micro-revision.i;                       \
#        fi; true
#        @rm -f micro-revision.tmp;

