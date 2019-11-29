import std.stdio, std.algorithm, std.conv, std.array, std.string;

void main()
{
    long[long][101] TABLE;

    auto nw = readln.chomp.split(" ");
    auto N = nw[0].to!int;
    auto W = nw[1].to!long;

    long[101] ws;
    long[101] vs;
    foreach (i; 0..N) {
        auto wv = readln.chomp.split(" ").map!(to!long);
        ws[i] = wv[0];
        vs[i] = wv[1];
    }

    long solve(int i, long v_sp) {
        if (v_sp in TABLE[i]) return TABLE[i][v_sp];

        long ret;
        if (i == N) {
            ret = 0;
        } else if (v_sp < ws[i]) {
            ret = solve(i+1, v_sp);
        } else {
            ret = max(solve(i+1, v_sp), solve(i+1, v_sp - ws[i]) + vs[i]);
        }

        return TABLE[i][v_sp] = ret;
    }

    writeln(solve(0, W));
}