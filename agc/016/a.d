import std.stdio, std.algorithm, std.conv, std.array, std.string;

bool check(const char[] arr) {
    auto p = arr[0];
    foreach (e; arr[1..$]) {
        if (p != e) return false;
    }
    return true;
}

void main()
{
    auto s = readln.chomp;

    if (check(s)) {
        writeln(0);
        return;
    }

    auto cs = s.uniq();

    auto min = int.max;
    foreach (c; cs) {
        int cnt;
        auto ss = s.dup;
        while (!check(ss)) {
            ++cnt;
            foreach (i, sc; ss) {
                if (i == ss.length - 1) {
                    ss.length -= 1;
                } else {
                    ss[i] = sc == c ? sc : ss[i+1];
                }
            }
        }
        if (cnt < min) min = cnt;
    }
    writeln(min);
}