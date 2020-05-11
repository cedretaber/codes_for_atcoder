import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto S = readln.chomp;
    auto T = readln.chomp;
    auto ss = new int[](S.length+1);
    foreach (i, c; S) {
        ss[i+1] = ss[i];
        if (c == 'A') {
            ss[i+1] += 1;
        } else {
            ss[i+1] += 2;
        }
        ss[i+1] %= 3;
    }
    auto tt = new int[](T.length+1);
    foreach (i, c; T) {
        tt[i+1] = tt[i];
        if (c == 'A') {
            tt[i+1] += 1;
        } else {
            tt[i+1] += 2;
        }
        tt[i+1] %= 3;
    }
    auto Q = readln.chomp.to!int;
    foreach (_q; 0..Q) {
        auto abcd = readln.split.to!(int[]);
        auto a = abcd[0]-1;
        auto b = abcd[1];
        auto c = abcd[2]-1;
        auto d = abcd[3];
        writeln((ss[b] - ss[a] + 3) % 3 == (tt[d] - tt[c] + 3) % 3 ? "YES" : "NO");
    }
}