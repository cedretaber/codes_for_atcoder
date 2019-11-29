import std.stdio, std.algorithm, std.conv, std.array, std.string;

void main()
{
    auto sa = readln.chomp;
    auto sb = readln.chomp;
    auto sc = readln.chomp;

    char t = 'a';
    for (;;) {
        switch (t) {
            case 'a':
                if (sa.empty) {
                    writeln("A");
                    return;
                }
                t = sa[0];
                sa = sa[1..$];
                break;
            case 'b':
                if (sb.empty) {
                    writeln("B");
                    return;
                }
                t = sb[0];
                sb = sb[1..$];
                break;
            case 'c':
                if (sc.empty) {
                    writeln("C");
                    return;
                }
                t = sc[0];
                sc = sc[1..$];
                break;
            default:
                return;
        }
    }
}