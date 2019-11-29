import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    bool n, w, s, e;
    foreach (c; readln.chomp) switch (c) {
        case 'N':
            n = true;
            break;
        case 'W':
            w = true;
            break;
        case 'S':
            s = true;
            break;
        case 'E':
            e = true;
            break;
        default:
    }
    writeln((n==s)&&(w==e) ? "Yes" : "No");
}