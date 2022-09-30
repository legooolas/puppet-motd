# used by other modules to register themselves in the motd
define motd::register(
  String  $content = '',
  Integer $order   = 10)
{
  include ::motd

  $body = $content ? {
    ''      => $name,
    default => $content,
  }

  $body_sprint = sprintf("%-${motd::printwidth}s", "  - ${body}")
  concat::fragment{"motd_fragment_${name}":
    target  => '/etc/motd',
    content => "  ${motd::char}   ${body_sprint}   ${motd::char}\n",
    order   => $order,
  }
}
