import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

void main()
{
    auto S_ = readln.chomp.to!(wchar[]);
    auto T = readln.chomp.to!(wchar[]);

    wchar[] S;
    foreach_reverse (i; 0..S_.length - T.length + 1) {
        auto s = S_.dup;
        foreach_reverse (j; 0..T.length) {
            if (S_[i+j] == '?')
                s[i+j] = T[j];
            else if (S_[i+j] != T[j])
                goto loop;
        }
        S = s;
        break;
        loop:
    }
    if (S) {
        foreach (ref c; S) if (c == '?') c = 'a';
        writeln(S);
    } else {
        writeln("UNRESTORABLE");
    }
}