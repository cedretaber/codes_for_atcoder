import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias LR = Tuple!(long, "l", long, "r");

void main()
{
    auto nxd = readln.split.to!(long[]);
    auto N = nxd[0];
    auto X = nxd[1];
    auto D = abs(nxd[2]);

    if (D == 0) {
        writeln(X == 0 ? 1 : N+1);
        return;
    }

    auto kcm = new long[](N);
    foreach (i; 0..N) {
        if (i != 0) {
            kcm[i] = kcm[i-1] + i;
        }
    }

    LR[][long] CM;
    foreach (k; 0..N+1) {
        if (k == 0) {
            CM[0] ~= LR(0, 0);
            continue;
        } else if (k == N) {
            CM[(k*X)%D] ~= LR(k*X/D + kcm[k-1]);
        }
        s = (k*X)%D;
        CM[s] ~= LR(kcm[k-1] + k*X/D, kcm[N-1] - kcm[N-k-1] + k*X/D);
    }
    long r;
}