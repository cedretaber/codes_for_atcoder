import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto ts = new int[](24*60 + 2);
    foreach (_; 0..N) {
        auto se = readln.chomp.split("-").to!(int[]);
        auto S = se[0]/100 * 60 + se[0] % 100;
        if (1 <= S%10 && S%10 <= 4) S = S/10*10;
        if (6 <= S%10 && S%10 <= 9) S = S/10*10 + 5;
        auto E = se[1]/100 * 60 + se[1] % 100;
        if (1 <= E%10 && E%10 <= 4) E = E/10*10 + 5;
        if (6 <= E%10 && E%10 <= 9) E = (E/10+1) * 10;

        ts[S] += 1;
        ts[E+1] -= 1;
    }

    int s, c;
    int[] SS, EE;
    foreach (i, t; ts) {
        if (s == 0 && t > 0) {
            ++c;
            SS ~= i.to!int;
        }
        if (s > 0 && s+t == 0) {
            EE ~= i.to!int - 1;
        }
        s += t;
    }
    foreach (i; 0..SS.length) {
        writefln!"%02d%02d-%02d%02d"(SS[i]/60, SS[i]%60, EE[i]/60, EE[i]%60);
    }
}