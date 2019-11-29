import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

void main()
{
    auto hw = readln.split.to!(int[]);
    auto H = hw[0];
    auto W = hw[1];

    wchar[][] ss;
    ss.length = H;
    foreach (i; 0..H) ss[i] = readln.chomp.to!(wchar[]);

    int[wchar] dic;
    foreach (s; ss) foreach (c; s) {
        if (c in dic) {
            dic[c] += 1;
        } else {
            dic[c] = 1;
        }
    }
    bool odd;
    foreach (n; dic.values) {
        if (n%2 == 1) {
            if (odd) {
                writeln("NO");
                return;
            }
            odd = true;
        }
    }

    if (odd && (W%2 == 0 || H%2 == 0)) {
        writeln("NO");
    } else {
        writeln("YES");
    }
}