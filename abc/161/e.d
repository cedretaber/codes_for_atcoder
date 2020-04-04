import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nkc = readln.split.to!(int[]);
    auto N = nkc[0];
    auto K = nkc[1];
    auto C = nkc[2];
    auto S = readln.chomp;

    int[] ls, rs;
    ls.length = N;
    ls[] = -1;
    rs.length = N;
    rs[] = -1;

    int i, c;
    foreach (_; 0..K) {
        while (S[i] == 'x') ++i;
        ls[i] = c++;
        i += C+1;
    }
    i = N-1;
    c = 0;
    foreach (_; 0..K) {
        while (S[i] == 'x') --i;
        rs[i] = c++;
        i -= C+1;
    }

    foreach (j; 0..N) {
        if (ls[j] == K-rs[j]-1) writeln(j+1);
    }
}