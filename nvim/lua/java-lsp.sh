#not used currently
java \
    -Declipse.application=org.eclipse.jdt.ls.core.id1 \
    -Dosgi.bundles.defaultStartLevel=4 \
    -Declipse.product=org.eclipse.jdt.ls.core.product \
    -Dlog.protocol=true \
    -Dlog.level=ALL \
    -Xmx1g \
    --add-modules=ALL-SYSTEM \
    --add-opens java.base/java.util=ALL-UNNAMED \
    --add-opens java.base/java.lang=ALL-UNNAMED \
    -jar /usr/share/java/jdtls/plugins/org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar \
    -configuration /usr/share/java/jdtls/config_SYSTEM \
    -data /home/mo/prog
