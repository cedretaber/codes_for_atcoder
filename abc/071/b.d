import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

void main()
{
    auto s = readln.chomp.to!(dchar[]);
    sort(s);
    s = s.uniq.array;
    if (s[0] != 'a') {
        writeln("a");
        return;
    }
    foreach (i, c; s[0..$-1]) {
        if (s[i+1] - c != 1) {
            writeln((c + 1).to!char);
            return;
        }
    }
    if (s[$-1] != 'z') {
        writeln("z");
        return;
    }
    writeln("None");
}