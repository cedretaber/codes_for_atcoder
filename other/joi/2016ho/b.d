import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto N = readln.chomp.to!int;
    auto S = readln.chomp.to!(char[]);
    auto jj = new long[](N);
    auto ii = new long[](N);
    foreach (i; 0..N) {
        if (i) jj[i] = jj[i-1];
        if (S[i] == 'J') jj[i] += 1;
    }
    foreach_reverse (i; 0..N) {
        if (i != N-1) ii[i] = ii[i+1];
        if (S[i] == 'I') ii[i] += 1;
    }
    long sum, jsum, isum;
    foreach (i; 0..N) if (S[i] == 'O') {
        sum += jj[i] * ii[i];
        jsum += jj[i];
        isum += ii[i];
    }
    auto res = max(jsum, isum);
    foreach (i; 1..N) res = max(res, jj[i-1] * ii[i]);
    writeln(sum + res);
}