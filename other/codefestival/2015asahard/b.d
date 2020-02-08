import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;
import std.container.slist;

alias S = Tuple!(size_t, "i", long, "a");

void main()
{
    auto nk = readln.split.to!(long[]);
    auto N = nk[0];
    auto K = nk[1];
    auto AS = readln.split.to!(long[]);

    auto BS = new long[](N+1);
    auto stk = new S[](N+1);
    stk[0] = S(0, 0);
    size_t j;
    long r = N, sm;
    foreach (i; 0..N) {
        sm += AS[i];
        if (i == 0) {
            r += AS[i];
        } else {
            r += abs(AS[i] - AS[i-1]);
        }
        if (i == N-1) r += AS[i];

        if (AS[i] > stk[j].a) {
            stk[++j] = S(i, AS[i]);
            continue;
        }

        while (AS[i] <= stk[j].a && AS[i] <= stk[j-1].a) {
            auto s = stk[j--];
            BS[i-s.i] += s.a - stk[j].a;
        }
        if (AS[i] <= stk[j].a) {
            auto s = stk[j];
            BS[i-s.i] += s.a - AS[i];
            stk[j].a = AS[i];
        }
    }
    while (j > 0) {
        auto s = stk[j--];
        BS[N-s.i] += s.a - stk[j].a;
    }

    r += (sm - K) * 2;
    foreach (ww, n; BS) if (ww) {
        auto w = ww.to!long;
        auto d = min(n, K/w);
        K -= d*w;
        r -= d*2;
    }

    writeln(r);
}