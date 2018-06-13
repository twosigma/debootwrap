#include <seccomp.h>

int main(void)
{
	scmp_filter_ctx ctx = seccomp_init(SCMP_ACT_ALLOW);
	seccomp_rule_add(ctx, SCMP_ACT_ERRNO(0), SCMP_SYS(chown), 0);
	seccomp_rule_add(ctx, SCMP_ACT_ERRNO(0), SCMP_SYS(fchown), 0);
	seccomp_rule_add(ctx, SCMP_ACT_ERRNO(0), SCMP_SYS(lchown), 0);
	seccomp_rule_add(ctx, SCMP_ACT_ERRNO(0), SCMP_SYS(fchownat), 0);
	seccomp_export_bpf(ctx, 1);
}
