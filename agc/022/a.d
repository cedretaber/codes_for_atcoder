import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

int[26] CS;

void main()
{
    auto S = readln.chomp.to!(char[]);
    foreach (c; S) ++CS[c-97];
    foreach (i, n; CS) {
        if (!n) {
            writeln(S ~ cast(char)(i+97));
            return;
        }
    }
    foreach_reverse (i, c; S) {
        while (c < 'z') {
            ++c;
            bool found;
            foreach (d; S[0..i]) {
                if (d == cast(char)c) {
                    found = true;
                    break;
                }
            }
            if (!found) {
                writeln(S[0..i] ~ cast(char)c);
                return;
            }
        }
    }
    writeln("-1");
}