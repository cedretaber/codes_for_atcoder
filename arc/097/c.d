import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

string[] substrings(string s)
{
    if (s == "") {
        return [];
    } else {
        string[] buf;
        foreach (i; 0..min(s.length, 5)) {
            buf ~= s[0..i+1];
        }
        return buf ~ substrings(s[1..$]);
    }
}

void main()
{
    auto s = readln.chomp;
    auto K = readln.chomp.to!int;

    auto substrs = substrings(s);
    sort(substrs);

    writeln(substrs.uniq.array[K-1]);
}