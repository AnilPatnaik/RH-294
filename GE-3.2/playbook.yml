---
- name: Deploy and start Cockpit service
  hosts: allservers
  become: true

  tasks:
    - name: Required packages are installed
      ansible.builtin.dnf:
        name:
          - "{{ server_pkg }}"
          - "{{ firewall_pkg }}"
        state: present

    - name: Start and enable {{ server_svc }}
      ansible.builtin.systemd_service:
        name: "{{ server_svc }}"
        state: started
        enabled: true

    - name: Start and enable {{ firewall_svc }}
      ansible.builtin.systemd_service:
        name: "{{ firewall_svc }}"
        state: started
        enabled: true

    - name: Allow the firewall service {{ firewall_rule }}
      ansible.posix.firewalld:
        service: "{{ firewall_rule }}"
        permanent: true
        immediate: true
        state: enabled

- name: Ensure that required users exists
  hosts: all
  become: true

  tasks:
    - name: Ensure the users with correct uid exists
      ansible.builtin.user:
        name: "{{ usr }}"
        uid: "{{ uid }}"
        state: present
      register: output_users

    - name: Printing user information
      ansible.builtin.debug:
        msg: >
          Home directory for the user {{ output_users['name'] }}
          with UID {{ output_users['uid'] }}
          is {{ output_users['home'] }}
