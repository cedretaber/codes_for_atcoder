import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum P = 10L^^9+7;

void main()
{
    auto hwk = readln.split.to!(int[]);
    auto H = hwk[0];
    auto W = hwk[1];
    auto K = hwk[2];

    long[] A, B;
    A.length = W;
    B.length = W;
    A[0] = 1;
    foreach (_; 0..H) {
        B[] = 0;
        foreach (w; 0..1<<(W-1)) {
            bool nxt;
            foreach (i; 0..W-2) if (!!(w & (1<<i)) && !!(w & (1<<(i+1)))) {
                nxt = true;
                break;
            }
            if (nxt) continue;
            foreach (i; 0..W) {
                if (i > 0 && (w & (1<<(i-1)))) {
                    B[i-1] = (B[i-1] + A[i]) % P;
                } else if (i < W-1 && (w & (1<<i))) {
                    B[i+1] = (B[i+1] + A[i]) % P;
                } else {
                    B[i] = (B[i] + A[i]) % P;
                }
            }
        }
        A[] = B[];
    }
    writeln(B[K-1]);
}