import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    int N, A, B, C;
    readf("%d %d %d %d", &N, &A, &B, &C);
    readln;

    int[] ls;
    ls.length = N;
    foreach (i; 0..N) ls[i] = readln.chomp.to!int;
    sort(ls);

    int mp = int.max;
    do {
        foreach (a; 1..N-1) {
            foreach (b; a+1..N) {
                foreach (c; b+1..N+1) {
                    int as, bs, cs;
                    foreach (i; 0..a) as += ls[i];
                    foreach (i; a..b) bs += ls[i];
                    foreach (i; b..c) cs += ls[i];

                    mp = min(mp, (a-1)*10 + (b-a-1)*10 + (c-b-1)*10 + abs(A - as) + abs(B - bs) + abs(C - cs));
                }
            }
        }
    } while (nextPermutation(ls));

    writeln(mp);
}