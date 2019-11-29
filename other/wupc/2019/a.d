import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto s = readln.chomp.to!(wchar[]);

    if (s.length == 1) {
        writeln(s);
        return;
    }
    for (size_t i = s.length-2;; --i) {
        if (s[i..i+2] == "WA") {
            s[i] = 'A';
            s[i+1] = 'C';
        }
        if (!i) break;
    }
    writeln(s);
}