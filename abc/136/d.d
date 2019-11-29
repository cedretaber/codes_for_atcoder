import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto S = readln.chomp.to!(char[]);
    int[] N;
    N.length = S.length;

    int x;
    foreach (i, c; S) {
        if (c == 'R') {
            ++x;
        } else {
            N[i-1] += (x+1)/2;
            N[i] += x/2;
            x = 0;
        }
    }
    x = 0;
    foreach_reverse (i, c; S) {
        if (c == 'L') {
            ++x;
        } else {
            N[i+1] += (x+1)/2;
            N[i] += x/2;
            x = 0;
        }
    }
    writeln(N.to!(string[]).join(" "));
}