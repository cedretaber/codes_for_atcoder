import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto T = readln.chomp;

    bool nc;
    int l, max_l;
    for (int i = 2; i <= T.length; i += 2) {
        if (T[i-2..i] == "??" || T[i-2..i] == "2?" || T[i-2..i] == "?5" || T[i-2..i] == "25") {
            l += 2;
            max_l = max(max_l, l);
        } else {
            l = 0;
        }
    }
    l = 0;
    for (int i = 3; i <= T.length; i += 2) {
        if (T[i-2..i] == "??" || T[i-2..i] == "2?" || T[i-2..i] == "?5" || T[i-2..i] == "25") {
            l += 2;
            max_l = max(max_l, l);
        } else {
            l = 0;
        }
    }
    writeln(max_l);
}